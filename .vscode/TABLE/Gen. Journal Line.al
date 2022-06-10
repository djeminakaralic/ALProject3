tableextension 50114 Gen_JournalLineExtends extends "Gen. Journal Line"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                ReadGLSetup: Record "General Ledger Setup";
                GLSetupRead: Boolean;
            begin

                ReadGLSetup.get;
                GLSetupRead := true;

                "Postponed VAT" := ("VAT Date" <> 0D) AND ("VAT Date" <> "Posting Date") AND ReadGLSetup."Unrealized VAT";
            end;
        }


        field(50001; "Postponed VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
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
        field(50021; "Note 1"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Note 2"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Note 3"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Payment Date And Time"; DateTime) //ED
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