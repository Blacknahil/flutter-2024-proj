import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { NotesService } from './notes.service';
import { CreateNotesDto } from './dto/create-notes.dto';
import { UpdateNotesDto } from './dto/update-notes.dto';
import { JwtAuthGuard } from 'src/auth/auth.guard';
import { AuthService } from 'src/auth/auth.service';

@Controller('notes')
export class NotesController {
  constructor(private readonly notesService: NotesService) {}

  //create notes by users

  // @UseGuards(JwtAuthGuard)
  @Post()
  create(@Body() createNoteDto: CreateNotesDto, @Req() req: any) {
    return this.notesService.create(createNoteDto, req.headers);
  }
  //Delete notes By Id
  // @UseGuards(JwtAuthGuard)
  @Delete(':id')
  remove(@Param('id') id: string, @Req() req: any) {
    return this.notesService.remove(id, req.headers['user-id']);
  }

  //findnotes get
  @UseGuards(JwtAuthGuard)
  @Get(':id')
  findById(@Param('id') id: string, @Req() req: any) {
    return this.notesService.findById(id, req.headers['user-id']);
  }

  //find all notes from my data base by user id
  @UseGuards(JwtAuthGuard)
  @Get()
  findAll(@Req() req: any) {
    return this.notesService.findAll(req.headers['user-id']);
  }

  //editing notes
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  update(
    @Body() updateNoteDto: UpdateNotesDto,
    @Param('id') id: string,
    @Req() req: any,
  ) {
    return this.notesService.update(id, updateNoteDto, req.headers['user-id']);
  }
}
