page 50246 "Employee Default Dimension"
{
    Caption = 'Employee Default Dimension';
    PageType = List;
    SourceTable = "Employee Default Dimension";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Dimension Code"; "Dimension Code")
                {
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                }
                field("Amount Distribution Coeff."; "Amount Distribution Coeff.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

