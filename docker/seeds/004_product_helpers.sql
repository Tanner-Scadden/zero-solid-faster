-- Helper functions for generating realistic data
CREATE OR REPLACE FUNCTION generate_description(
    product_name TEXT,
    features TEXT[],
    benefits TEXT[]
) RETURNS TEXT AS $$
DECLARE
    selected_features TEXT[];
    selected_benefits TEXT[];
BEGIN
    -- Randomly select 2-4 features and benefits
    selected_features := ARRAY(
        SELECT features[i]
        FROM generate_series(1, array_length(features, 1)) i
        ORDER BY random()
        LIMIT floor(random() * 3 + 2)::int
    );
    
    selected_benefits := ARRAY(
        SELECT benefits[i]
        FROM generate_series(1, array_length(benefits, 1)) i
        ORDER BY random()
        LIMIT floor(random() * 3 + 2)::int
    );
    
    RETURN product_name || '. ' ||
           array_to_string(selected_features, ' ') || ' ' ||
           array_to_string(selected_benefits, ' ');
END;
$$ LANGUAGE plpgsql; 