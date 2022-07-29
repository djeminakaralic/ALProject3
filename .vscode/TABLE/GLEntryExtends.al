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
        field(50003; "Payment Type Code"; Code[10])
        {
            Caption = 'Vrsta uplate';
            NotBlank = true;
        }
        field(50004; "Payment Method"; Text[20])
        {
            Caption = 'Payment Method';
            NotBlank = true;
        }
        field(50005; "Cashier Code"; Code[10])
        {
            Caption = 'Cashier Code';
            NotBlank = true;
        }
    }

    var
        myInt: Integer;
}