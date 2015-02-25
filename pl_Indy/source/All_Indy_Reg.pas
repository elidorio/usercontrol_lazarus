{ ****************************************************

 INDY Modification 
 by PilotLogic for CodeTyphon Studio

****************************************************** }


unit All_Indy_Reg;

interface

{$I IdCompilerDefines.inc}

uses
  Classes, SysUtils,LResources,PropEdits, ComponentEditors,

  //...... Core ..................

  IdIcmpClient,
  IdSocks,
  IdDsnCoreResourceStrings,
  IdAntiFreeze,
  IdCmdTCPClient,
  IdCmdTCPServer,
  IdIOHandlerStream,
  IdInterceptSimLog,
  IdInterceptThrottler,
  IdIPMCastClient,
  IdIPMCastServer,
  IdLogDebug,
  IdLogEvent,
  IdLogFile,
  IdLogStream,
  IdSchedulerOfThread,
  IdSchedulerOfThreadDefault,
  IdSchedulerOfThreadPool,
  IdServerIOHandlerSocket,
  IdServerIOHandlerStack,
  IdSimpleServer,
  IdThreadComponent,
  IdUDPClient,
  IdUDPServer,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdIntercept,
  IdTCPServer,
  IdTCPClient,

  //..........Dsng Components ....................

  IdDsnResourceStrings,
  IdBlockCipherIntercept,
  IdChargenServer,
  IdChargenUDPServer,
  IdCoder3to4,
  IdCoderBinHex4,
  IdCoderMIME,
  IdCoderQuotedPrintable,
  IdCoderUUE,
  IdCoderXXE,
  {$IFDEF USE_ZLIB_UNIT}
  IdCompressorZLib,
  IdCompressionIntercept,
  {$ENDIF}
  IdConnectThroughHttpProxy,
  IdCookieManager,
  IdResourceStringsCore,
  IdDateTimeStamp,
  IdDayTime,
  IdDayTimeServer,
  IdDayTimeUDP,
  IdDayTimeUDPServer,
  IdDICT,
  IdDICTServer,
  IdDiscardServer,
  IdDiscardUDPServer,
  IdDsnRegister,
  IdDNSResolver,
  IdDNSServer,
  IdEcho,
  IdEchoServer,
  IdEchoUDP,
  IdEchoUDPServer,
  IdFinger,
  IdFingerServer,
  IdFSP,
  IdFTP,
  IdFTPServer,
  IdGopher,
  IdGopherServer,
  IdHashMessageDigest,
  IdHTTP,
  IdHTTPProxyServer,
  IdHTTPServer,
  IdIPAddrMon,
  IdIdent,
  IdIdentServer,
  IdIMAP4,
  IdIMAP4Server,
  IdIPWatch,
  IdIRC,
  IdIrcServer,
  IdLPR,
  IdMailBox,
  IdMappedFTP,
  IdMappedPortTCP,
  IdMappedTelnet,
  IdMappedPOP3,
  IdMappedPortUDP,
  IdMessage,
  IdMessageCoderMIME,
  IdMessageCoderYenc,
  IdNetworkCalculator,
  IdNNTP,
  IdNNTPServer,
  IdPOP3,
  IdPOP3Server,
  IdQotd,
  IdQotdServer,
  IdQOTDUDP,
  IdQOTDUDPServer,
  IdResourceStrings,
  IdResourceStringsProtocols,
  IdRexec,
  IdRexecServer,
  IdRSH,
  IdRSHServer,
  IdSASLAnonymous,
  IdSASLDigest,
  IdSASLExternal,
  IdSASLLogin,
  IdSASLOTP,
  IdSASLPlain,
  IdSASLSKey,
  IdSASLUserPass,
  IdSASL_CRAM_MD5,
  IdSASL_CRAM_SHA1,
  IdServerInterceptLogEvent,
  IdServerInterceptLogFile,
  IdSMTP,
  IdSMTPRelay,
  IdSMTPServer,
  IdSNMP,
  IdSNPP,
  IdSNTP,
  IdSocksServer,
  {$IFDEF USE_OPENSSL}
  IdSSLOpenSSL,
  {$ENDIF}
  IdSysLog,
  IdSysLogMessage,
  IdSysLogServer,
  IdSystat,
  IdSystatServer,
  IdSystatUDP,
  IdSystatUDPServer,
  IdTelnet,
  IdTelnetServer,
  IdTime,
  IdTimeServer,
  IdTimeUDP,
  IdTimeUDPServer,
  IdTrivialFTP,
  IdTrivialFTPServer,
  IdUnixTime,
  IdUnixTimeServer,
  IdUnixTimeUDP,
  IdUnixTimeUDPServer,
  IdUserAccounts,
  IdUserPassProvider,
  IdVCard,
  IdWebDAV,
  IdWhois,
  IdWhoIsServer,

   //.......... For Properties editors ....................

  IdDsnBaseCmpEdt,
  IdBaseComponent,
  IdComponent,
  IdGlobal,
  IdDsnPropEdBinding,
  IdStack,
  IdSocketHandle,
  IdDsnSASLListEditor,
  IdSASLCollection;


type

  TIdPropEdBinding = class(TPropertyEditor)
  protected
    FValue : String;
    property Value : String read FValue write FValue;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;


procedure Register;

implementation

procedure TIdPropEdBinding.Edit;
var
  pSockets: TIdSocketHandles;
begin
  inherited Edit;
  pSockets := TIdSocketHandles(GetOrdValue);
  with TIdPropEdBindingEntry.Create do
  try
    Caption := TComponent(GetComponent(0)).Name;
    DefaultPort := pSockets.DefaultPort;
    Value := GetListValues(pSockets);
    SetList(Value);
    if Execute then
    begin
      Value := GetList;
      FillHandleList(Value, pSockets);
    end;
  finally
    Free;
  end;
end;

function TIdPropEdBinding.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

function TIdPropEdBinding.GetValue: string;
var
  pSockets: TIdSocketHandles;
begin
  pSockets := TIdSocketHandles(GetOrdValue);
  Result := GetListValues(pSockets);
end;

procedure TIdPropEdBinding.SetValue(const Value: string);
var
  pSockets: TIdSocketHandles;
begin
  inherited SetValue(Value);
  pSockets := TIdSocketHandles(GetOrdValue);
  pSockets.BeginUpdate;
  try
    FillHandleList(Value, pSockets);
  finally
    pSockets.EndUpdate;
  end;
end;

//=================================================================================

procedure Register;
begin

  //-------------- Core --------------------------------

  RegisterComponents(RSRegIndyClients+CoreSuffix, [
    TIdTCPClient
   ,TIdUDPClient
   ,TIdCmdTCPClient
   ,TIdIPMCastClient
   ,TIdIcmpClient
  ]);
  RegisterComponents(RSRegIndyServers+CoreSuffix, [
   TIdUDPServer,
   TIdCmdTCPServer,
   TIdSimpleServer,
   TIdTCPServer,
   TIdIPMCastServer
  ]);
  RegisterComponents(RSRegIndyIOHandlers+CoreSuffix,[
    TIdIOHandlerStack
   ,TIdIOHandlerStream
   ,TIdServerIOHandlerStack
  ]);
  RegisterComponents(RSRegIndyIntercepts+CoreSuffix, [
    TIdConnectionIntercept
   ,TIdInterceptSimLog
   ,TIdInterceptThrottler
   ,TIdLogDebug
   ,TIdLogEvent
   ,TIdLogFile
   ,TIdLogStream
  ]);
  RegisterComponents(RSRegIndyMisc+CoreSuffix, [
   TIdSocksInfo,
   TIdAntiFreeze,
   TIdSchedulerOfThreadDefault,
   TIdSchedulerOfThreadPool,
   TIdThreadComponent
  ]);

  //..........Dsng Components ....................


  RegisterComponents(RSRegIndyClients+ RSProtam, [
   TIdDayTime,
   TIdDayTimeUDP,
   TIdDICT,
   TIdDNSResolver,
   TIdEcho,
   TIdEchoUDP,
   TIdFinger,
   TIdFSP,
   TIdFTP,
   TIdGopher,
   TIdHTTP,
   TIdIdent,
   TIdIMAP4,
   TIdIRC,
   TIdLPR]);

  RegisterComponents(RSRegIndyClients+RSProtnz, [
   TIdNNTP,
   TIdPOP3,
   TIdQOTD,
   TIdQOTDUDP,
   TIdRexec,
   TIdRSH,
   TIdSMTP,
   TIdSMTPRelay,
   TIdSNMP,
   TIdSNPP,
   TIdSNTP,
   TIdSysLog,
   TIdSystat,
   TIdSystatUDP,
   TIdTelnet,
   TIdTime,
   TIdTimeUDP,
   TIdTrivialFTP,
   TIdUnixTime,
   TIdUnixTimeUDP,
   TIdWhois]);

  RegisterComponents(RSRegIndyServers+RSProtam, [
   TIdChargenServer,
   TIdChargenUDPServer,
   TIdDayTimeServer,
   TIdDayTimeUDPServer,
   TIdDICTServer,
   TIdDISCARDServer,
   TIdDiscardUDPServer,
   TIdDNSServer,
   TIdECHOServer,
   TIdEchoUDPServer,
   TIdFingerServer,
   TIdFTPServer,
   TIdGopherServer,
   TIdHTTPProxyServer,
   TIdHTTPServer,
   TIdIdentServer,
   TIdIMAP4Server,
   TIdIRCServer]);

  RegisterComponents(RSRegIndyServers+RSProtnz, [
  TIdNNTPServer,
   TIdPOP3Server,
   TIdQOTDServer,
   TIdQotdUDPServer,
   TIdRexecServer,
   TIdRSHServer,
   TIdSMTPServer,
   TIdSocksServer,
   TIdSyslogServer,
   TIdSystatServer,
   TIdSystatUDPServer,
   TIdTelnetServer,
   TIdTimeServer,
   TIdTimeUDPServer,
   TIdTrivialFTPServer,
   TIdUnixTimeServer,
   TIdUnixTimeUDPServer,
   TIdWhoIsServer]);

  RegisterComponents(RSRegIndyServers+RSMappedPort,[
   TIdMappedFTP,
   TIdMappedPOP3,
   TIdMappedPortTCP,
   TIdMappedPortUDP,
   TIdMappedTelnet]);

  RegisterComponents(RSRegIndyIntercepts+RSProt, [
   {$IFDEF USEZLIBUNIT}
   TIdCompressionIntercept,
   TIdServerCompressionIntercept,
   {$ENDIF}
   TIdBlockCipherIntercept,
   TIdServerInterceptLogEvent,
   TIdServerInterceptLogFile
   ]);

  RegisterComponents(RSRegSASL+RSProt, [
   TIdSASLAnonymous,
   TIdSASLCRAMMD5,
   TIdSASLDigest,
   TIdSASLExternal,
   TIdSASLLogin,
   TIdSASLOTP,
   TIdSASLPlain,
   TIdSASLSKey,
   TIdUserPassProvider
   ]);

  {$IFDEF USEOPENSSL}
  RegisterComponents(RSRegIndyIOHandlers+RSProt, [
   TIdServerIOHandlerSSLOpenSSL,
   TIdSSLIOHandlerSocketOpenSSL
   ]);
  {$ENDIF}

  RegisterComponents(RSRegIndyMisc+RSProt, [
   TIdConnectThroughHttpProxy,
   {$IFDEF USE_ZLIB_UNIT}
   TIdCompressorZLib,
   {$ENDIF}
   TIdCookieManager,
   TIdDateTimeStamp,

   TIdIPWatch,
   TIdIPAddrMon,
   //TIdHL7,
   TIdMailBox,
   TIdMessage,
   TIdNetworkCalculator,
   TIdSysLogMessage,
   TIdUserManager,
   TIdVCard
   ]);

  RegisterComponents(RSRegIndyMisc+RSProt + RSEncoder, [
   TIdEncoderMIME,
   TIdEncoderUUE,
   TIdEncoderXXE,
   TIdEncoderQuotedPrintable,
   TIdMessageEncoderMIME,
   TIdMessageEncoderYenc
   ]);

  RegisterComponents(RSRegIndyMisc+RSProt + RSDecoder, [
   TIdDecoderMIME,
   TIdDecoderUUE,
   TIdDecoderXXE,
   TIdDecoderQuotedPrintable,
   TIdMessageDecoderMIME,
   TIdMessageDecoderYenc
   ]);


  RegisterPropertyEditor(TypeInfo(TIdSocketHandles), nil, '', TIdPropEdBinding);
  RegisterComponentEditor(TIdBaseComponent, TIdBaseComponentEditor);
  RegisterPropertyEditor(TypeInfo(TIdSASLEntries), nil, '', TIdPropEdSASL);

end;


initialization
{$I All_Indy_Reg.lrs}

end.

