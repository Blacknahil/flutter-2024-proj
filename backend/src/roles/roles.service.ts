import { Injectable } from '@nestjs/common';

@Injectable()
export class RolesService {
  private userRoles = new Map<string, string[]>();
  assignRoles(userId: string, roles: string[]) {
    this.userRoles.set(userId, roles);
  }

  getUserRoles(userId: string): string[] {
    return this.userRoles.get(userId) || [];
  }
}
