page 50006 Municipalities
{
    Caption = 'Municipalities';
    PageType = List;
    SourceTable = "Municipality";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                }
                field(Name;Name)
                {
                }
                field("Tax Number";"Tax Number")
                {
                }
                field(City;City)
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

