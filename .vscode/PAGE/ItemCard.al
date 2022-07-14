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
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Net Invoiced Qty.")
        {
            Visible = false;
        }
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("Sales Blocked")
        {
            Visible = false;
        }
        modify("Include Inventory")
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