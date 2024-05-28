import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { NotesModule } from './notes/notes.module';
import { AdminModule } from './admin/admin.module';
import { MongooseModule } from '@nestjs/mongoose';
import { createMongooseOptions } from 'database.config';
// import { AuthMiddleware } from './auth/auth.middleware';
import { FoldersModule } from './folders/folders.module';

@Module({
  imports: [
    AuthModule,
    UsersModule,
    NotesModule,
    AdminModule,
    AdminModule,
    MongooseModule.forRootAsync({
      useFactory: createMongooseOptions,
    }),
    FoldersModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    // consumer.apply(AuthMiddleware).forRoutes('*');
  }
}
