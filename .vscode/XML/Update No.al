xmlport 50008 "Employee No import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Employee';
                UseTemporary = false;
                textelement(JMB)
                {
                    MinOccurs = Zero;
                }
                textelement(Iznos)
                {
                    MinOccurs = Zero;
                }
                textelement(Prezime)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin



                    /*    EmpOLD2.Reset();
                        EmpOLD2.SetFilter("No.", '%1', JMB);
                        if EmpOLD2.FindFirst() then begin
                            if EmpOLD3.get(EmpOLD2."No.") then
                                EmpOLD3.Rename(EmpOLD2."No." + '_' + format(EmpOLD2.Count))

                        end;
    */

                    brojac := brojac + 1;




                    EmpOLD.Reset();
                    EmpOLD.SetFilter("First Name", '%1', Iznos);
                    EmpOLD.SetFilter("Last Name", '%1', Prezime);

                    if EmpOLD.FindFirst() then begin
                        EmpOLD.Rename(JMB);
                        Evaluate(IznosInt, JMB);
                        EmpOLD.Order := IznosInt;
                        EmpOLD.Modify();
                    end;





                END;


            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    trigger OnPreXMLport()
    var
        myInt: Integer;
    begin



        brojac := 765;

    end;

    var
        IznosInt: Integer;
        EmpOLD: Record Employee;
        EmpOLD2: Record Employee;
        brojac: Integer;
        EmpOLD3: Record Employee;
}

