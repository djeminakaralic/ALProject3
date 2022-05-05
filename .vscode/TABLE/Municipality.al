table 50006 Municipality
{
    Caption = 'Municipality';
    DrillDownPageID = Municipalities;
    LookupPageID = Municipalities;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                "Tax Number" := Code;
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Tax Number"; Code[10])
        {
            Caption = 'Tax Number';
        }
        field(4; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(5; "DP Code"; Code[10])
        {
            Caption = 'DP Code';
            TableRelation = Canton;
        }
        field(6; "For Calculation 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            /*ĐK TableRelation = IF (Country/Region Code=FILTER('')) "Post Code".City
                             ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));

             trigger OnValidate()
             begin
                 PostCode.LookUpPostCode(City,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
             end;
             */
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
        field(9; "Entity Code"; Code[10])
        {
            CalcFormula = Lookup (Canton."Entity Code" WHERE(Code = FIELD("DP Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; City)
        {
        }
        key(Key3; "Country/Region Code")
        {
        }
        key(Key4; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Tax Number" := Code;
    end;

    trigger OnRename()
    begin
        "Tax Number" := Code;
    end;

    var
        PostCode: Record "Post Code";
}

