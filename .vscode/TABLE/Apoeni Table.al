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
                if Rec.Apoeni.AsInteger() < 7 then begin
                    //ApoeniText := FORMAT(Rec.Apoeni); //probati bez ovoga   
                    //Evaluate(ApoeniDecimal, ApoeniText);
                    if Evaluate(ApoeniDecimal, Format(Rec.Apoeni))
                    then
                        Evaluate(ApoeniDecimal, Format(Rec.Apoeni))
                    else
                        ApoeniDecimal := 0

                end
                else
                    if Rec.Apoeni.AsInteger() = 8 then
                        ApoeniDecimal := 0.5
                    else
                        if Rec.Apoeni.AsInteger() = 9 then
                            ApoeniDecimal := 0.2
                        else
                            if Rec.Apoeni.AsInteger() = 10 then
                                ApoeniDecimal := 0.1
                            else
                                if Rec.Apoeni.AsInteger() = 11 then ApoeniDecimal := 0.05;
                //Message(FORMAT(ApoeniDecimal));
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
                Validate(Apoeni,Rec.Apoeni);

           /*     if Rec.Apoeni.AsInteger() < 7 then begin
                    //ApoeniText := FORMAT(Rec.Apoeni); //probati bez ovoga   
                    //Evaluate(ApoeniDecimal, ApoeniText);
                    Evaluate(ApoeniDecimal, Format(Rec.Apoeni));

                end
                else
                    if Rec.Apoeni.AsInteger() = 8 then
                        ApoeniDecimal := 0.5
                    else
                        if Rec.Apoeni.AsInteger() = 9 then
                            ApoeniDecimal := 0.2
                        else
                            if Rec.Apoeni.AsInteger() = 10 then
                                ApoeniDecimal := 0.1
                            else
                                if Rec.Apoeni.AsInteger() = 11 then ApoeniDecimal := 0.05;*/
                if (ApoeniDecimal <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniDecimal * Rec.Quantity;
            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
                field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
                field(6; CurrentJnlBatchName; Code[10])
        {
            Caption = 'Current Journal Batch Name';
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

