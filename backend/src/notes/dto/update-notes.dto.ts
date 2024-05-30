import { PartialType } from '@nestjs/mapped-types';
import { CreateNotesDto } from './create-notes.dto';

export class UpdateNotesDto extends PartialType(CreateNotesDto) {}
