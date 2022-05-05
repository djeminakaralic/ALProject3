tableextension 50124 Value_EntryExtends extends "Value Entry"
{
    fields
    {

        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
    }

    procedure GetCostAmt(): Decimal
    begin
        //+BH1.00
        IF "Cost Amount (Actual)" = 0 THEN
            EXIT("Cost Amount (Expected)");
        EXIT("Cost Amount (Actual)");
        //-BH1.00
    end;
}