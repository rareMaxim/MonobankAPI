program NotTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.DateUtils,
  Monobank in 'Monobank.pas',
  Monobank.Types in 'Monobank.Types.pas',
  Fix.REST.Client in 'Fix.REST.Client.pas';

procedure Main;
var
  Mono: TMonobank;
  Currency: TmonoCurrencyInfo;
  UserInfo: TmonoUserInfo;
  LAccount: TmonoAccount;
  LStatement: TmonoStatementItem;
begin
  Mono := TMonobank.Create;
  Mono.Token := 'uGf9lM';
  try
    for Currency in Mono.Currency do
    begin
      Writeln(Currency.CurrencyCodeA);
    end;
    UserInfo := Mono.ClientInfo;
    Writeln(UserInfo.Name);
    for LAccount in UserInfo.accounts do
    begin
      for LStatement in Mono.Statement(LAccount.id, IncDay(Now, -7), Now) do
      begin
        Writeln(LAccount.currencyCode.ToString, ' ', DateToStr(UnixToDateTime(LStatement.time)),
          ' ', LStatement.amount);
      end;
    end;

  finally
    Mono.Free;
  end;
end;

begin
  try
    Main;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.

