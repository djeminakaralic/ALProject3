tableextension 50114 Gen_JournalLineExtends extends "Gen. Journal Line"
{

    fields
    {
        modify("Customer Id")
        {
            trigger OnAfterValidate()

            begin
                Customer.Reset();
                Customer.SetFilter("No.", '%1', "Customer Id");
                if Customer.FindFirst() then begin
                    "Social status" := Customer."Social status category";
                end;

            end;
        }
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
        field(50025; "Given amount"; Decimal)
        {
            Caption = 'Given amount';

            trigger OnValidate()
            begin
                "To return" := "Given amount" - Amount;
            end;

        }
        field(50026; "To return"; Decimal)
        {
            Caption = 'To return';

        }
        field(50027; "Redni broj"; Integer)
        {
            Caption = 'Redni broj uplate';

        }
        field(50028; "Social status"; Option)
        {
            OptionMembers = ,S;
            TableRelation = Customer."Social status category";
            Caption = 'Social status category';
        }
        field(50029; "Payment Type"; code[10])
        {

            //TableRelation = "Payment Type";
            Caption = 'Social status category';
        }


    }

    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        //  GenJnlPostPreview.

        //"Gen. Jnl.-Post Preview".SaveCustLedgEntry(Rec);
        "Redni broj" := 0;
        "Redni broj" := xRec."Redni broj" + 1;


    end;


    var
        myInt: Integer;
        Customer: Record Customer;



}