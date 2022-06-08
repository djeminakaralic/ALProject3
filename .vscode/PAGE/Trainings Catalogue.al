page 50058 "Trainings Catalogue"
{

    Caption = 'Katalog treninga';
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
                field(Name; Name)
                { }
                field(TypeOF; TypeOF) { }
                field(Type; Type)
                {

                }
                field(Location; Location) { }
                field(Month; Month) { }



            }
        }


    }
}