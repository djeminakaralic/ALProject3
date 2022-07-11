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
                if Rec.Apoeni < 7 then begin
                    ApoeniText := FORMAT(Rec.Apoeni); //probati bez ovoga   
                    Evaluate(ApoeniDecimal, ApoeniText);

                end
                else
                    if Rec.Apoeni = 8 then
                        ApoeniDecimal := 0.5
                    else
                        if Rec.Apoeni = 9 then
                            ApoeniDecimal := 0.2
                        else
                            if Rec.Apoeni = 10 then
                                ApoeniDecimal := 0.1
                            else
                                if Rec.Apoeni = 11 then ApoeniDecimal := 0.05;
                Message(FORMAT(ApoeniDecimal));
                //Evaluate(ApoeniINT, Format(Rec.Apoeni));
                if (ApoeniDecimal <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniDecimal * Rec.Quantity;
            end;
        }
        field(3; Quantity; Integer)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin

                if (ApoeniDecimal <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniDecimal * Rec.Quantity;
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
        ApoeniDecimal: Decimal;
        ApoeniText: Text[10];
}

