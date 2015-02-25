{%MainUnit IdGlobal.pas}

{ ****************************************************

 INDY Modification 
 by PilotLogic for CodeTyphon Studio

****************************************************** }

type
  TIdStreamHelperVCL = class
  public
    class function ReadBytes(
          const AStream: TStream;
          var VBytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; {$IFDEF DOTNET} static; {$ENDIF}
    class function Write(
          const AStream: TStream;
          const ABytes: TIdBytes;
          const ACount: Integer = -1;
          const AOffset: Integer = 0) : Integer; {$IFDEF DOTNET} static; {$ENDIF}
    class function Seek(
          const AStream: TStream;
          const AOffset: TIdStreamSize;
          const AOrigin: TSeekOrigin) : TIdStreamSize; {$IFDEF DOTNET} static; {$ENDIF}
  end;
  
 TIdStreamHelper = TIdStreamHelperVCL; //9999 
