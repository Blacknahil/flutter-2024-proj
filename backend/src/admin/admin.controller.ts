import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { AdminService } from './admin.service';
import { Role } from 'src/roles/role.enum';
import { Roles } from 'src/roles/roles.decorator';
import { JwtAuthGuard } from 'src/auth/auth.guard';
import { RolesGuard } from 'src/roles/roles.guard';

@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Get('allwithnotes')
  getAllUsers() {
    return this.adminService.getAllUsersWithNotes();
  }

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Delete('note/:id')
  deleteNote(@Param('id') id: string) {
    console.log('delete note in');
    return this.adminService.deleteNote(id);
  }

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Delete('user/:id')
  deleteUser(@Param('id') id: string) {
    console.log('delete user');
    return this.adminService.deleteUserAndNotes(id);
  }

  // @Roles(Role.Admin)
  // @UseGuards(JwtAuthGuard,RolesGuard)
  @Patch('user/ban/:id')
  banUser(@Param('id') id:string){
    return this.adminService.banUser(id)
  }
  // @Roles(Role.Admin)
  // @UseGuards(JwtAuthGuard,RolesGuard)
  @Patch('user/unban/:id')
  unBanUser(@Param('id') id:string){
    return this.adminService.unBanUser(id)

}
}
