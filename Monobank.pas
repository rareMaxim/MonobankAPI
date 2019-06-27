unit Monobank;

interface

uses
  Monobank.Types,
  Fix.REST.Client;

type
  TMonobank = class
  private
    FClient: TRESTClient;
    FToken: string;
  protected
    procedure DoCheckToken;
  public
    /// <summary>
    ///   Отримання курсів валют
    /// </summary>
    /// <remarks>
    ///   Отримати базовий перелік курсів валют monobank. Інформація кешується та оновлюється не частіше 1 разу на 5 хвилин.
    /// </remarks>
    function Currency: TArray<TmonoCurrencyInfo>;
    /// <summary>
    ///   Інформація про клієнта
    /// </summary>
    /// <remarks>
    ///   Отримання інформації про клієнта та переліку його рахунків. Обмеження на використання функції не частіше ніж 1 раз у 60 секунд.
    /// </remarks>
    function ClientInfo: TmonoUserInfo;
    function Statement(AAccount: string; AFrom, ATo: Int64): TArray<TmonoStatementItem>; overload;
    function Statement(AAccount: string; AFrom, ATo: TDateTime): TArray<TmonoStatementItem>; overload;
    constructor Create;
    destructor Destroy; override;
    property Token: string read FToken write FToken;
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  REST.Types;
{ TMonobank }

function TMonobank.ClientInfo: TmonoUserInfo;
begin
  DoCheckToken;
  FClient.Params.AddHeader('X-Token', Token);
  Result := FClient.GetEntity<TmonoUserInfo>('/personal/client-info');
end;

constructor TMonobank.Create;
begin
  FClient := TRESTClient.Create('https://api.monobank.ua/');
end;

function TMonobank.Currency: TArray<TmonoCurrencyInfo>;
begin
  Result := FClient.GetEntityArray<TmonoCurrencyInfo>('/bank/currency');
end;

destructor TMonobank.Destroy;
begin
  FClient.Free;
  inherited;
end;

procedure TMonobank.DoCheckToken;
begin
  if Token.IsEmpty then
    raise Exception.Create('Token is empty');
end;

function TMonobank.Statement(AAccount: string; AFrom, ATo: TDateTime): TArray<TmonoStatementItem>;
begin
  Result := Statement(AAccount, DateTimeToUnix(AFrom), DateTimeToUnix(ATo));
end;

function TMonobank.Statement(AAccount: string; AFrom, ATo: Int64): TArray<TmonoStatementItem>;
var
  LQuery: string;
begin
  DoCheckToken;
  LQuery := '/personal/statement/{account}/{from}/{to}';
  LQuery := LQuery.Replace('{account}', AAccount).Replace('{from}', AFrom.ToString).Replace('{to}', ATo.ToString);
  FClient.Params.AddHeader('X-Token', Token);
  Result := FClient.GetEntityArray<TmonoStatementItem>(LQuery);
end;

end.

