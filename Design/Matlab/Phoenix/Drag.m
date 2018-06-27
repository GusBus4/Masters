cp_dis_vec = [
                0; 
                0; 
                0.1
             ]

body_force_vector = [
                        1;
                        2;
                        3
                    ]

drag_moment =   [
                    body_force_vector(2)*cp_dis_vec(3) + body_force_vector(3)*cp_dis_vec(2);
                    body_force_vector(3)*cp_dis_vec(1) - body_force_vector(1)*cp_dis_vec(3);
                    body_force_vector(1)*cp_dis_vec(2) - body_force_vector(2)*cp_dis_vec(1)
                ]
                
                