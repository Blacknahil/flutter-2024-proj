import { PartialType } from '@nestjs/mapped-types';
import { CreateUsersDto } from './create-users.dto';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class UpdateUsersDto extends PartialType(CreateUsersDto) {

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    oldPassword?:string

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    newPassword?:string

    @IsOptional()
    @IsNotEmpty()
    @IsString()
    confirmPassword?:string

}
