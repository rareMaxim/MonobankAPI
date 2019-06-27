unit Fix.REST.Client;

interface

uses
  REST.Client;

type
  TRESTClient = class(REST.Client.TRESTClient)
    function GetEntity<T: class, constructor>(const AResource: string): T;
  end;

implementation

uses
  REST.Json,
  REST.Types;
{ TRESTClient }

function TRESTClient.GetEntity<T>(const AResource: string): T;
var
  LRequest: TRESTRequest;
begin
  LRequest := TRESTRequest.Create(Self);
  try
    LRequest.Method := rmGET;
    LRequest.Resource := AResource;
    LRequest.Execute;
    Result := TJson.JsonToObject<T>(LRequest.Response.JSONText);
  finally
    LRequest.Free;
  end;
end;

end.

