tableextension 50126 ServiceInvoiceHeaderExtends extends "Service Invoice Header"
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

            DataClassification = ToBeClassified;

        }

        field(50002; "Fiscal User"; COde[20])
        {

            DataClassification = ToBeClassified;

        }

        field(50003; "Fiscal No."; COde[20])
        {

            DataClassification = ToBeClassified;

        }

        field(50004; "Fiscal No. Printed"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50005; "Fiscal Printer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }


    }
}