tableextension 50115 SalesCrMemoHeaderExtends extends "Sales Cr.Memo Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }


        //Fiscal DateTime

        field(50001; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50002; "Fiscal User"; COde[50])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50003; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }

        field(50004; "Fiscal No. Printed"; Boolean)
        {
            Caption = 'Fiscal No. Printed';
            DataClassification = ToBeClassified;

        }

        field(50005; "Fiscal Printer Code"; Code[20])
        {
            Caption = 'Fiscal Printer Code';
            DataClassification = ToBeClassified;

        }
        field(50007; "Internal Correction"; Boolean)
        {

        }
        field(50008; Prepayment; Boolean)
        {

        }




    }
}