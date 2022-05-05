tableextension 50111 PurchaseLineExtends extends "Purchase Line"
{
    fields
    {
        //    VAT Base (retro.)
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50002; "Order Code"; Text[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "Item Vendor"."Vendor Item No." where
            ("Item No." = field("No."), "Vendor No." = field("Buy-from Vendor No."));
            //"Item Vendor"."Vendor Item No." WHERE (Item No.=FIELD(No.),Vendor No.=FIELD(Buy-from Vendor No.))

        }
        field(50003; "Quality Control Needed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //FA Charge No.


        field(50006; "FA Charge No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Item No. for PDV Assign."; Code[30])
        {
            DataClassification = ToBeClassified;
        }


    }
    var
        myInt: Integer;
}
