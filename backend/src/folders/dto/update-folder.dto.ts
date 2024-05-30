import { PartialType } from '@nestjs/mapped-types';
import { CreateFolderDto } from './create-folder.dto';
import { IsArray, IsMongoId, IsNumber, IsOptional, IsString } from 'class-validator';
import { Types } from 'mongoose';

export class UpdateFolderDto extends PartialType(CreateFolderDto) {

    @IsString()
    @IsOptional()
    title?: string;

    @IsOptional()
    @IsNumber()
    notesCount:any;

    @IsArray()
    @IsOptional()
    notesIds?:string[];


}
