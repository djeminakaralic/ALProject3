tableextension 50105 CustomerExtends extends "Customer"
{
    fields
    {
        //    VAT Base (retro.)
        field(50005; "Entity Code"; Code[2048])
        {

            DataClassification = ToBeClassified;
            TableRelation = Entity;
        }

        field(50000; "Registration No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }


        field(50004; "Entry Finished"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //VAT Amount (retro.)

        field(50006; "Old No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        //VAT

        field(50007; "Payment Terms Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }


        field(50008; "Payment Terms Code 3"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }



        field(50010; "Date Filter Block"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "No. Of Blocks"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Blocked By" WHERE("No." = field("No."), Date = field("Date Filter Block"), Blocked
              = filter(All)));

        }


        field(50011; "Prepayment (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."), "Initial Entry Global Dim. 1"
              = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
              "Currency Code" = field("Currency Filter"), Prepayment = FILTER(true)));

        }


        field(50017; "Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(50018; "Debenture"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "Insurance (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }


        field(50022; "Allowed to Unlock Customer 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50023; "Allowed to Unlock Customer 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Orderer"; text[1000])
        {
            Caption = 'Orderer';
        }
        field(50025; "Contract Number"; Text[1000])
        {
            Caption = 'Contract Number';
        }
        field(50026; "Order person"; Text[1000])
        {
            Caption = 'Order person';
        }
        field(50027; "Responsible Person"; Text[1000])
        {
            Caption = 'Responsible Person';

        }
        field(50028; "Designer"; Text[1000])
        {
            Caption = 'Designer';
        }
        field(50029; "Project manager"; Text[1000])
        {
            Caption = 'Project manager';
        }
        field(50030; "Responsible Person Infodom"; Text[1000])
        {
            Caption = 'Responsible Person Infodom';
        }

        field(50031; "Message Code"; Text[30])
        {
            TableRelation = Template_Message."Message Code" where("Type" = filter("Mail notification"), CustomerCOde = field("No."));
            Caption = 'Message Code';
        }
        field(50032; "Poruka test"; Text[30])
        {
            Caption = 'Message test';
        }
        field(50033; "Social status category"; Option)
        {
            Caption = 'Social status category';
            OptionMembers = ,S;
        }





    }

    var
        myInt: Integer;
}