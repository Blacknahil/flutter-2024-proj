import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Options,
  Param,
  Patch,
  Post,
  Put,
  Req,
  Request,
  Res,
  UseGuards,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { CreateUsersDto } from './dto/create-users.dto';
import { UsersService } from './users.service';
import { User } from './schemas/user.schema';
import { UpdateUsersDto } from './dto/update-users.dto';
import { LoginUserDto } from './dto/login-users.dto';
import * as bcrypt from 'bcrypt';
import { AuthService } from '../auth/auth.service';
import { JwtAuthGuard } from 'src/auth/auth.guard';
import { Response } from 'express';
import { Roles } from 'src/roles/roles.decorator';
import { Role } from 'src/roles/role.enum';
import { RolesGuard } from 'src/roles/roles.guard';
import { request } from 'http';
import { access } from 'fs';

@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly authService: AuthService,
  ) {}

  @Post('register')
  // @UsePipes(new ValidationPipe({transform:true}))
  async register(@Body() createUsersDto: CreateUsersDto): Promise<User> {
    // console.log("inside register")
    const hashedPassword = await bcrypt.hash(createUsersDto.password, 10);

    const userWithHashedPassword: CreateUsersDto = {
      ...createUsersDto,
      password: hashedPassword,
    };
    return this.usersService.register(userWithHashedPassword);
  }

  @Post('login')
  @UsePipes(new ValidationPipe({ transform: true }))
  async login(
    @Body() loginUserDto: LoginUserDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    const { access_token, user } = await this.authService.login(
      loginUserDto.email,
      loginUserDto.password,
    );
    try {
      if (!access_token) {
        throw new BadRequestException('Invalid credentials');
      }
      response.cookie('jwt', access_token, { httpOnly: true });
      // console.log(user,access_token);
      return { user, access_token };
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  @UseGuards(JwtAuthGuard)
  @Get('profile/:id')
  async profile(@Param('id') id: string): Promise<User> {
    return this.usersService.profile(id);
  }

  @UseGuards(JwtAuthGuard)
  @Patch('update/:id')
  async updateProfile(
    @Param('id') id: string,
    @Body() updateUserDto: UpdateUsersDto,
  ): Promise<any> {
    return this.usersService.updateProfile(id, updateUserDto);
  }

  // @Roles(Role.Admin)
  //now a user can delte its account or admin can delete the account of others
  
  // @UseGuards(JwtAuthGuard, RolesGuard)
  @Delete('delete/:id')
  async deleteAccount(@Param('id') id: string,@Req() req): Promise<User> {

    return this.usersService.deleteAccount(id,req.user);
  }

  //Admin route to get all users
  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RolesGuard)
  // @UseGuards()
  @Get('all')
  async getAllUsers(@Req() request): Promise<User[]> {
    console.log();
    return this.usersService.findAll();
  }

  @UseGuards(JwtAuthGuard)
  @Post('logout')
  async logout(@Res({ passthrough: true }) response: Response) {
    response.clearCookie('jwt');
  }
}
