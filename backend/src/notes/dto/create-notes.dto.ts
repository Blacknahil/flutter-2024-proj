import { isNotEmpty, IsNotEmpty } from 'class-validator';
import { Types } from 'mongoose';

export class CreateNotesDto {
  @IsNotEmpty()
  title: string;

  @IsNotEmpty()
  content: string;

  @IsNotEmpty()
  userId: string;

  @IsNotEmpty()
  folderId:string;

  // @IsNotEmpty()
  // notesId:string;
}
