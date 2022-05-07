tableextension 50109 VendorLedgerEntryExtends extends "Vendor Ledger Entry"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }


        field(50001; "G/L Account"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group"."Payables Account" where(code = field("Vendor Posting Group")));

        }

        field(50002; "Vendor Type"; Option)

        {
            OptionMembers = ,Ink,"Spare parts";

            DataClassification = ToBeClassified;

        }

        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(50003; "Compensation"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
    }


    var
        myInt: Integer;



}