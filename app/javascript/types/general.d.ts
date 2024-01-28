export interface IUserLogin {
  email: string;
  password: string;
}

export interface IRegisterUser extends IUserLogin {
  password_confirmation: string;
  phone: string;
}

export interface ICurrentUser {
  id: number;
}
