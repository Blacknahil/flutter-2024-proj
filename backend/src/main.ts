import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import { UsersService } from './users/users.service';
import { Role } from './roles/role.enum';
import { NestExpressApplication } from '@nestjs/platform-express'; // Import the NestExpressApplication type
const port = 5001;

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule, {
    cors: true,
  });
  // app.enableCors(options:{
  //   origin:'http://localhost:5001',
  //   Credential:true
  // })
  await app.use(cookieParser());
  const userService = app.get(UsersService);
  const admins = await userService.findAdminUsers();
  if (admins.length === 0) {
    const admin1 = {
      name: 'nahom',
      email: 'nahom.garefo@aait.edu.et',
      password: 'nahomnahom',
      role: Role.Admin,
    };
    const admin2 = {
      name: 'betsegaw',
      email: 'betsegaw@gmail.com',
      password: 'betsegaw',
      role: Role.Admin,
    };
    await userService.createAdmin(admin1);
    await userService.createAdmin(admin2);
  }

  await app.listen(port);
  console.log(`Application is running on port: http://localhost:${port}`);
}
bootstrap();
