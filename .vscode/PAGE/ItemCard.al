pageextension 50179 ItemCard extends "Item Card"
{
    //ED

    layout
    {
        
        /*addafter(Name)
        {            
            field("Vendor Class";"Vendor Class")
            {
                ApplicationArea = all;
            }
            field("Vendor Group";"Vendor Group")
            {
                ApplicationArea = all;
            }
            field("Vendor Subgroup";"Vendor Subgroup")
            {
                ApplicationArea = all;
            }
            field("Industrial Classification";"Industrial Classification")
            {
                ApplicationArea = all;
            }
        }*/
      
        modify(Blocked)
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }

        /*movebefore(Amount; "Applies-to Doc. No.")
        moveafter("Bal. VAT Amount"; "Applies-to Doc. Type")
       */

        /*addafter("Amount (LCY)")
        {
            field(Apoeni; Apoeni)
            {
                ApplicationArea = all;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.Update();
                    Rec."Given amount" := Rec.Apoeni;
                end;
            }
            field("Given amount"; "Given amount")
            {
                ApplicationArea = all;
            }
            field("To return"; "To return")
            {
                ApplicationArea = all;
            }
        }
        modify("Applied (Yes/No)")
        {
            Visible = false;
        }
        modify(Description)
        {
            Editable = false;
        }*/
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
}