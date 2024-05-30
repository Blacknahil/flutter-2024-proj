import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './auth.guard';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: AuthService;

  beforeEach(async () => {
    authService = { login: jest.fn(), validateUser: jest.fn() } as any;

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        { provide: AuthService, useValue: authService },
        JwtAuthGuard,
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should login a user', async () => {
    const dto = { username: 'test', password: 'test' };
    (authService.login as jest.Mock).mockResolvedValue('test-token');

    expect(await controller.login(dto, {}, {})).toBe('test-token');
    expect(authService.login).toHaveBeenCalledWith(dto.username, dto.password);
  });

  it('should get a user profile', () => {
    const req = { user: { username: 'test' } };

    expect(controller.profile(req)).toBe(req.user);
  });
});
