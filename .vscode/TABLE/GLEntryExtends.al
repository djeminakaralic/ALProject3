tableextension 50106 GLEntryExtends extends "G/L Entry"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "Contact link"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact."No.";
        }
        //VAT Amount (retro.)

        field(50001; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }


        field(50002; "Vendor Order No."; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Order No." where("No." = field("Document No.")));
        }


    }

    var
        myInt: Integer;
}