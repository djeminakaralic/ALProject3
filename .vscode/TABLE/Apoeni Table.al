table 51067 "Apoeni"
{
    //ED
    Caption = 'Apoeni';
    DrillDownPageID = "Apoeni Page";
    LookupPageID = "Apoeni Page";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Apoeni; Enum "Apoeni Enum")
        {
            Caption = 'Apoeni';

            trigger OnValidate()
            begin
                //ApoeniText := FORMAT(Rec.Apoeni); //probati bez ovoga   
                //Evaluate(ApoeniINT, ApoeniText);
                Evaluate(ApoeniINT, Format(Rec.Apoeni));
                if (ApoeniINT <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniINT * Rec.Quantity;
            end;
        }
        field(3; Quantity; Integer)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                if (ApoeniINT <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniINT * Rec.Quantity;
            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ApoeniINT: Integer;
        ApoeniText: Text[10];
}

