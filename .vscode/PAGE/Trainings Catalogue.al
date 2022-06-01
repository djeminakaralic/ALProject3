page 50058 "Trainings Catalogue"
{

    Caption = 'Trainings Catalogue';
    PageType = List;
    SourceTable = "Training Catalogue";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; Code)
                {

                }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }
                field("Travel cost home"; "Travel cost home") { }
                field("Travel cost ino"; "Travel cost ino") { }
                field("Daily rate home"; "Daily rate home") { }
                field("Daily rate ino"; "Daily rate ino") { }
                field("Number of days"; "Number of days") { }
                field("Daily rate home SUM"; "Daily rate home SUM") { }
                field("Daily rate ino SUM"; "Daily rate ino SUM") { }
                field(Kotizacija; Kotizacija) { }
                field(Hours; Hours) { }


            }
        }


    }
}