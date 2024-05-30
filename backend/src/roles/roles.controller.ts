import { Controller, Get, Param } from '@nestjs/common';
import { RolesService } from './roles.service';

@Controller('roles')
export class RolesController {
  constructor(private readonly rolesService: RolesService) {}

  // @Get('userid')
  // getUserRoles(@Param('userId') userId:string){
  //     return this.rolesService.getUserRoles(userId);
  // }
}
