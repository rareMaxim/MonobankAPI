unit Monobank.Types;

interface

type
  /// <summary>
  ///   Перелік курсів. Кожна валютна пара може мати одне і більше полів з rateSell, rateBuy, rateCross.
  /// </summary>
  TmonoCurrencyInfo = class
  private
    FcurrencyCodeA: Integer;
    FcurrencyCodeB: Integer;
    Fdate: Integer;
    FrateSell: Single;
    FrateBuy: Single;
    FrateCross: Single;
  public
    /// <summary>
    ///
    /// </summary>
    property CurrencyCodeA: Integer read FcurrencyCodeA;
    property CurrencyCodeB: Integer read FcurrencyCodeB;
    property Date: Integer read Fdate;
    property RateSell: Single read FrateSell;
    property RateBuy: Single read FrateBuy;
    property RateCross: Single read FrateCross;
  end;

  TmonoAccount = class
  private
    Fid: string;
    Fbalance: Int64;
    FcreditLimit: Int64;
    FcurrencyCode: Integer;
    FcashbackType: string;
  published
    /// <summary>
    ///   Ідентифікатор рахунку
    /// </summary>
    property id: string read Fid write Fid;
    /// <summary>
    ///   Баланс рахунку в мінімальних одиницях валюти (копійках, центах)
    /// </summary>
    property balance: Int64 read Fbalance write Fbalance;
    /// <summary>
    ///   Кредитний ліміт
    /// </summary>
    property creditLimit: Int64 read FcreditLimit write FcreditLimit;
    /// <summary>
    ///   Код валюти рахунку відповідно ISO 4217
    /// </summary>
    property currencyCode: Integer read FcurrencyCode write FcurrencyCode;
    /// <summary>
    ///   Тип кешбеку який нараховується на рахунок
    /// </summary>
    property cashbackType: string read FcashbackType write FcashbackType;
  end;

  /// <summary>
  ///   Опис клієнта та його рахунків.
  /// </summary>

  TmonoUserInfo = class
  private
    Fname: string;
    Faccounts: TArray<TmonoAccount>;
  public
    /// <summary>
    ///   Ім'я клієнта
    /// </summary>
    property Name: string read Fname;
    /// <summary>
    ///   Перелік доступних рахунків
    /// </summary>
    property accounts: TArray<TmonoAccount> read Faccounts write Faccounts;
  end;

  TmonoStatementItem = class
  private
    Fid: string;
    Ftime: Integer;
    Fdescription: string;
    Fmcc: Integer;
    Fhold: boolean;
    Famount: Int64;
    FoperationAmount: Int64;
    FcurrencyCode: Integer;
    FcommissionRate: Int64;
    FcashbackAmount: Int64;
    Fbalance: int64;
  published
    property id: string read Fid write Fid;
    property time: Integer read Ftime write Ftime;
    property description: string read Fdescription write Fdescription;
    property mcc: Integer read Fmcc write Fmcc;
    property hold: boolean read Fhold write Fhold;
    property amount: Int64 read Famount write Famount;
    property operationAmount: Int64 read FoperationAmount write FoperationAmount;
    property currencyCode: Integer read FcurrencyCode write FcurrencyCode;
    property commissionRate: Int64 read FcommissionRate write FcommissionRate;
    property cashbackAmount: Int64 read FcashbackAmount write FcashbackAmount;
    property balance: int64 read Fbalance write Fbalance;
  end;

implementation

end.

