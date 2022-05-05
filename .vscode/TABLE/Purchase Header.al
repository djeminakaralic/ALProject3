tableextension 50000 PurchaseHeaderExtends extends "Purchase Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }

        field(50001; "Purchase Is Finished"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50003; "Prepayment"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Vendor Type"; Option)

        {
            OptionMembers = ,Ink,"Spare parts";

            DataClassification = ToBeClassified;

        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "VAT Date" := Today;
        "Language Code" := 'HRV';

    end;

    var
        myInt: Integer;
}