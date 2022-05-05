tableextension 50129 SalesInvoiceHeaderExtends extends "Sales Invoice Header"
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
        field(50008; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
            Description = 'BH1.01';
        }
        field(50009; "Total Packaging"; Text[250])
        {
            Caption = 'Total Packaging';
            Description = 'BH1.01';
        }
        field(50010; "Total Value Letters"; Text[250])
        {
            Caption = 'Total Value Letters';
            Description = 'BH1.01';
        }
        field(50011; "Country of Origin"; Code[20])
        {
            Caption = 'Country of Origin';
            Description = 'BH1.01';
            TableRelation = "Country/Region";
        }
        field(50028; "Note 1"; Text[250])
        {
            Caption = 'Note 1';
            Description = 'BH1.01';
        }
        field(50029; "Note 2"; Text[250])
        {
            Caption = 'Note 2';
            Description = 'BH1.01';
        }
        field(50030; "Note 3"; Text[250])
        {
            Caption = 'Note 3';
            Description = 'BH1.01';
        }
        field(50015; "Due Date 2"; Date)
        {
            Caption = 'Due Date 2';
        }
        field(50016; "Due Date 3"; Date)
        {
            Caption = 'Due Date';
        }
        field(50017; "Payment Terms Code 2"; Code[10])
        {
            Caption = 'Payment Terms Code 2';
            TableRelation = "Payment Terms";
        }
        field(50018; "Payment Terms Code 3"; Code[10])
        {
            Caption = 'Payment Terms Code 3';
            TableRelation = "Payment Terms";
        }
        field(50033; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }


    }
}