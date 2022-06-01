page 50067 "Training Time Entries"
{


    Caption = 'Evidencija održavanja treninga/edukacija';
    PageType = List;
    SourceTable = "Training Time Entry";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {

                }
                field(Code2; Code2)
                {

                }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }
                field("Start date"; "Start date") { }
                field("End date"; "End date") { }
                field(Status; Status) { }
                field("Number of people"; "Number of people") { }


            }
        }


    }
}


