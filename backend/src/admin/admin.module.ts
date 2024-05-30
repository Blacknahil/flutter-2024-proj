import { Module } from '@nestjs/common';
import { AdminService } from './admin.service';
import { AdminController } from './admin.controller';
import { NotesModule } from 'src/notes/notes.module';
import { MongooseModule } from '@nestjs/mongoose';
import { Note, NoteSchema } from 'src/notes/schemas/note.schema';
import { UsersModule } from 'src/users/users.module';
import { User, UserSchema } from 'src/users/schemas/user.schema';
import { AuthService } from 'src/auth/auth.service';

@Module({
  imports: [
    NotesModule,
    MongooseModule.forFeature([
      { name: Note.name, schema: NoteSchema },
      { name: User.name, schema: UserSchema },
    ]),
    UsersModule,
  ],
  controllers: [AdminController],
  providers: [AdminService, AuthService],
})
export class AdminModule {}
