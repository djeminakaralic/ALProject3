page 50058 "Trainings Catalogue"
{

    Caption = 'Katalog treninga';
    PageType = List;
    SourceTable = "Training Catalogue";
    RefreshOnActivate = true;
    InsertAllowed = true;


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
                field(TypeOF; TypeOF)
                {

                    trigger OnValidate()



                    begin
                        Trainingtype.Reset();
                        Trainingtype.SetFilter(Code, '%1', TypeOF);
                        if Trainingtype.FindFirst() then begin

                            "Type of name" := Trainingtype.Description;
                        end;

                    end;
                }
                field("Type of name"; "Type of name") { }
                field(Type; Type)
                {

                }
                //field(Location; Location) { }
                field(Month; Month) { }
                field(Year; Year)
                {

                }



            }
        }


    }
    var
        Trainingtype: Record "Training Type";
}