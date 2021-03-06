pageextension 50179 ItemCard extends "Item Card"
{
    //ED

    layout
    {
        addafter("Service Item Group")
        {
            field("Item Subgroup"; "Item Subgroup")
            {
                ApplicationArea = all;
            }
        }

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
            Visible = false;
        }
        modify("Purchasing Blocked")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        modify("Price/Profit Calculation")
        {
            Visible = false;
        }
        modify("Last Counting Period Update")
        {
            Visible = false;
        }
        modify("Next Counting Start Date")
        {
            Visible = false;
        }
        modify("Next Counting End Date")
        {
            Visible = false;
        }
        modify("Identifier Code")
        {
            Visible = false;
        }
        modify("Use Cross-Docking")
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Caption = 'Pra??enje artikla';
        }
        modify(Planning)
        {
            Visible = false;
        }
        modify(Replenishment_Assembly)
        {
            Visible = false;
        }
        modify(SpecialPurchPricesAndDiscountsTxt)
        {
            Visible = false;
        }
        modify(SpecialPricesAndDiscountsTxt)
        {
            Visible = false;
        }



    }

    actions
    {
    }

}