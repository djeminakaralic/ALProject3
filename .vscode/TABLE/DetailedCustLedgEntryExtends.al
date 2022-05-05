tableextension 50108 DetailedCustLedgEntryExtends extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        //    VAT Base (retro.)


        field(50000; "Prepayment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Cust. Ledger Entry".Prepayment where("Entry No." = field("Cust. Ledger Entry No.")));


        }


    }

    var
        myInt: Integer;
}