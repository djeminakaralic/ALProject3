tableextension 50145 PostCode extends "Post Code"
{
    fields
    {
        field(50000; "Entity Code"; Code[20])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }


        field(50001; "Canton Code"; Code[10])
        {
            Caption = 'Canton Code';
            TableRelation = Canton;
        }
        field(50002; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50003; "Tax Number"; Text[5])
        {
            Caption = 'Tax Number';
        }
        field(50004; "Transport Basis"; Decimal)
        {
            Caption = 'Transport Basis';
        }
        field(50005; "Tax Bank Account"; Text[18])
        {
            Caption = 'Tax Bank Account';
        }
        field(50006; "Tax Authority"; Text[30])
        {
            Caption = 'Tax Authority';
        }
        field(50007; "RS - High Tax Percentage"; Decimal)
        {
            Caption = 'RS - High Tax Percentage';
        }
        field(50008; "Transport Amount"; Decimal)
        {
            Caption = 'Transport Amount';
        }
    }
    procedure LookUpPostCode(var City: Text[30]; var PostCode: Code[20]; ReturnValues: Boolean)
    var
        PostCodeRec: Record "Post Code";
    begin
        //NK01 start
        IF NOT GUIALLOWED THEN
            EXIT;
        PostCodeRec.SETCURRENTKEY(Code, City);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;

        IF (PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;

            "Entity Code" := PostCodeRec."Entity Code";

        END;
        //NK01 end
    end;

    var
        myInt: Integer;
}