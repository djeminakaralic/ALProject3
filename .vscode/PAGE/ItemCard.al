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
        modify(Replenishment_Production)
        {
            Caption = 'Proizvodnja';
        }
        modify("Purchasing Blocked")
        {
            Visible = false;
        }

        /*addafter("Item Category Code")
        {
            field("Product Group Code";"Product Group Code")
            {
                ApplicationArea = all;
            }
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