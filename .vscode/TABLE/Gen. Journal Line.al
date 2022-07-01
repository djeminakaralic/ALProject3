tableextension 50114 Gen_JournalLineExtends extends "Gen. Journal Line"
{

    fields
    {
        /*modify("Customer Id")
        {
            trigger OnAfterValidate()

            begin
                Customer.Reset();
                Customer.SetFilter("No.", '%1', "Customer Id");
                if Customer.FindFirst() then begin
                    "Social status" := Customer."Social status category";
                end;

            end;
        }*/
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
        field(50024; "Payment DT"; DateTime) //ED
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Given amount"; Decimal)
        {
            Caption = 'Given amount';

            trigger OnValidate()
            begin
                if ABS("Given amount") < ABS(Amount) then
                    Error(Text001);
                if (Amount <> 0) then
                    "To return" := ABS("Given amount") - ABS(Amount);
            end;

        }
        field(50026; "To return"; Decimal)
        {
            Caption = 'To return';
            Editable = false;
        }
        field(50027; "No. Line"; Integer)
        {
            Caption = 'Redni broj uplate';
        }
        field(50028; "Social status"; enum "Social Status")
        {
            Caption = 'Social status category';
        }
        field(50030; "Address_Cust"; Text[100])
        {
            Caption = 'Address';
        }
        field(50031; "RegistrationNo_Cust"; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50032; "VATRegistrationNo_Cust"; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(50033; "Payment Type"; Code[10])
        {
            Caption = 'Payment Type';
            TableRelation = "Payment Type";
        }
        field(50034; "Payment Method"; enum "Payment Method") //ED
        {
            Caption = 'Payment Method';
        }
        field(50035; "City_Cust"; Text[30]) //ED
        {
            Caption = 'City';
        }
        field(50036; Phone_Cust; Text[30]) //ED
        {
            Caption = 'Phone';
        }
        field(50037; MobilePhone_Cust; Text[30]) //ED
        {
            Caption = 'Mobile Phone';
        }
        field(50038; Email_Cust; Text[80]) //ED
        {
            Caption = 'E-mail';
        }
        field(50039; Balance_Cust; Decimal) //ED
        {
            Caption = 'Balance';
        }

        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                if ("Given amount" <> 0) AND (ABS("Given amount") < ABS(Amount)) then
                    Error(Text001);
                if ("Given amount" <> 0) then
                    "To return" := ABS("Given amount") - ABS(Amount);
            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                if ("Account Type" = "Account Type"::Customer) and ("Account No." <> '') then begin

                    Customer.Get("Account No.");
                    "Social status" := Customer."Social status category";
                    Address_Cust := Customer.Address;
                    RegistrationNo_Cust := Customer."Registration No.";
                    VATRegistrationNo_Cust := Customer."VAT Registration No.";
                    City_Cust := Customer.City;
                    Balance_Cust := Customer."Balance Due";
                    Phone_Cust := Customer."Phone No.";
                    MobilePhone_Cust := Customer."Mobile Phone No.";
                    Email_Cust := Customer."E-Mail";


                end;
            end;
        }
    }

    trigger OnInsert()
    begin

        if GJLine.FindLast() then
            Rec."No. Line" := GJLine."No. Line" + 1
        else
            Rec."No. Line" := 1;

    end;


    var
        myInt: Integer;
        Customer: Record Customer;
        GJLine: Record "Gen. Journal Line";
        Text001: Label 'Given amount cannot be less than amount.';
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
}