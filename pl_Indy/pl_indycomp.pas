{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit pl_indycomp;

interface

uses
  All_Indy_Reg, IdAbout, IdAboutVCL, IdAntiFreeze, IdDsnBaseCmpEdt, 
  IdDsnCoreResourceStrings, IdDsnPropEdBinding, IdDsnPropEdBindingVCL, 
  IdDsnResourceStrings, IdDsnSASLListEditor, IdDsnSASLListEditorForm, 
  IdDsnSASLListEditorFormVCL, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('All_Indy_Reg', @All_Indy_Reg.Register);
end;

initialization
  RegisterPackage('pl_indycomp', @Register);
end.
