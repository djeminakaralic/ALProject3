tableextension 50104 VATEntryExtends extends "VAT Entry"
{
    fields
    {
        //    VAT Base (retro.)
        field(50003; "VAT Base (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //VAT Amount (retro.)
        field(50002; "VAT Amount (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50006; Import; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50000; "VAT Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Postponed VAT"; boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Unrealized Amount (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Unrealized Base (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Vendor Entity Code"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Full VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("VAT Entry"."VAT Amount (retro.)" where("Document No." = field("Document No."), Import = filter(true)));

        }

        field(50009; "Total Entry No."; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count ("VAT Entry" where("Document No." = field("Document No."), Import = filter(false)));
        }

        field(50007; "Customer Entity Code"; Code[2048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Customer"."Entity Code" where("No." = field("Bill-to/Pay-to No.")));


        }

    }

    var
        myInt: Integer;
}