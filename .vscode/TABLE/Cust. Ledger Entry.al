tableextension 50107 CustLedgerEntryExtends extends "Cust. Ledger Entry"
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
            CalcFormula = lookup("Customer Posting Group"."Receivables Account" where(Code = field("Customer Posting Group")));

        }

        field(50003; "Compensation"; Boolean)
        {

            DataClassification = ToBeClassified;

        }


        field(50008; "Due Date 2"; Date)
        {

            DataClassification = ToBeClassified;

        }

        field(50009; "Due Date 3"; Date)
        {

            DataClassification = ToBeClassified;

        }
        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bin Checked"; Boolean)
        {

            DataClassification = ToBeClassified;
        }


    }
    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        //  GenJnlPostPreview.

        //"Gen. Jnl.-Post Preview".SaveCustLedgEntry(Rec);
    end;

    var
        myInt: Integer;



}