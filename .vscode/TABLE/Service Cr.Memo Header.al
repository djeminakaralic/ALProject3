tableextension 50127 ServiceCr_Memo_HeaderExtends extends "Service Cr.Memo Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }


        //Fiscal DateTime

        field(50002; "Fiscal DateTime"; DateTime)
        {

            DataClassification = ToBeClassified;

        }

        field(50003; "Fiscal User"; COde[20])
        {

            DataClassification = ToBeClassified;

        }

        field(50004; "Fiscal No."; COde[20])
        {

            DataClassification = ToBeClassified;

        }

        field(50005; "Fiscal No. Printed"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(500001; "Fiscal Printer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }


    }
}