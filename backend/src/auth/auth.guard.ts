import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request } from 'express';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(
    private readonly authService: AuthService,
    private jwtService: JwtService,
    private usersService: UsersService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = request.headers.authorization.split(' ')[1];

    if (!token) {
      console.log('token not found');
      throw new UnauthorizedException();
    }
    try {
      // console.log("inside try")
      // console.log(token);
      const payload = await this.jwtService.verifyAsync(token);
      // console.log(payload.id);
      const user = await this.usersService.findOne(payload.id);
      if (!user) {
        console.log('user not found');
        throw new UnauthorizedException();
      }
      request['user'] = user;
      return true;
    } catch (e) {
      console.log(e);
      throw new UnauthorizedException();
    }
  }
}
